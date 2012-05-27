;; Copyright (C) 2011 Austin<austiny.cn@gmail.com>
          
;; This program is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation, either version 3 of
;; the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

(defconst weibo-api-send-comment "statuses/comment")
(defconst weibo-api-send-reply "statuses/reply")
(defconst weibo-api-comments-by-me-timeline "statuses/comments_by_me")
(defconst weibo-api-comments-to-me-timeline "statuses/comments_to_me")

;; id: 评论ID
;; text: 评论内容
;; source: 评论来源
;; favorited: 是否收藏
;; truncated: 是否被截断
;; created_at: 评论时间
;; user: 评论人信息,结构参考user
;; status: 评论的微博,结构参考status
;; reply_comment 评论来源，数据结构跟comment一致
(defstruct weibo-comment id text source
  favorited truncated created_at
  user status reply_comment)

(defun weibo-make-comment (node)
  (make-weibo-comment
   :id (weibo-get-node-text node 'id)
   :text (weibo-get-node-text node 'text)
   :source (mm-decode-coding-string (nth 2 (nth 2 (weibo-get-node node 'source))) 'utf-8)
   :favorited (weibo-get-node-text node 'favorited)
   :truncated (weibo-get-node-text node 'truncated)
   :created_at (weibo-get-node-text node 'created_at)
   :user (weibo-make-user (weibo-get-node node 'user))
   :status (let ((status (weibo-get-node node 'status)))
	     (when status
	       (weibo-make-status status)))
   :reply_comment (let ((reply_comment (weibo-get-node node 'reply_comment)))
		    (when reply_comment
		      (weibo-make-comment reply_comment)))))

(defun weibo-pull-comment (node parse-func new type)
  (let* ((keyword (if new "since_id" "max_id"))
	 (id (and node-data (weibo-comment-id node-data)))
	 (param (and id (format "?%s=%s" keyword id))))
    (with-temp-message (concat "获取评论 " param "...")
      (weibo-get-data type
		      parse-func param
		      "comments" new)
      (weibo-timeline-reset-count "1"))))

(defun weibo-comment-pretty-printer (comment &optional p)
  (weibo-insert-comment comment t))

(defun weibo-insert-comment (comment with-retweet)
  (when comment
    (insert weibo-timeline-separator "\n")
    (unless with-retweet (insert "\t"))
    (weibo-insert-user (weibo-comment-user comment) nil)
    (insert "评论道：\n")
    (unless with-retweet (insert "\t"))
    (weibo-timeline-insert-text (weibo-comment-text comment))
    (let ((status (weibo-comment-status comment))
	  (reply_comment (weibo-comment-reply_comment comment)))
      (when reply_comment
	(let ((text (weibo-comment-text reply_comment)))
	  (insert weibo-timeline-sub-separator "\n")
	  (unless with-retweet (insert "\t"))
	  (weibo-timeline-insert-text
	   (concat "回复" (weibo-user-screen_name
			   (weibo-comment-user reply_comment))
		   "的评论："
		   (if (< (length text) 30) text
		     (concat (substring text 0 27) "。。。"))))))
      (when with-retweet
	(when status
	  (weibo-insert-status status t)))
      (unless with-retweet (insert "\t"))      
      (insert "  " (weibo-parse-status-time (weibo-comment-created_at comment)) "  来自：" (weibo-comment-source comment) "\n"))))

(defun weibo-reply-comment (comment &rest p)
  (when comment
    (let ((cid (weibo-comment-id comment))
	   (id (weibo-status-id (weibo-comment-status comment)))
	   (user_name (weibo-user-screen_name (weibo-comment-user comment))))
      (weibo-create-post (format "回复@%s:" user_name) "回复评论" nil 'weibo-send-reply cid id))))

(defun weibo-send-reply (text cid id)
  (let ((data nil)
	(api weibo-api-send-reply))
    (cond
     ((= (length text) 0) (message "不能发表空回复") nil)
     ((> (length text) 140) (message "回复长度须小于140字") nil)
     (t
      (add-to-list 'data `("comment" . ,text))
      (add-to-list 'data `("id" . ,id))
      (add-to-list 'data `("cid" . ,cid))
      (weibo-post-data api 'weibo-parse-data-result data nil nil)))))

(defun weibo-send-comment (text comment-id)
  (let ((data nil)
	(api weibo-api-send-comment))
    (cond
     ((= (length text) 0) (message "不能发表空评论") nil)
     ((> (length text) 140) (message "评论长度须小于140字") nil)
     (t
      (add-to-list 'data `("comment" . ,text))
      (add-to-list 'data `("id" . ,comment-id))
      (weibo-post-data api 'weibo-parse-data-result data nil nil)))))

(defun weibo-look-comment-status (comment &rest p)
  (when comment
    (weibo-timeline-set-provider (weibo-status-comments-timeline-provider
				  (weibo-comment-status comment)))))

(defun weibo-comment-update-status (comment-list type)
  (when comment-list
    (let ((ids (mapconcat (lambda (comment)
			    (weibo-status-id (weibo-comment-status comment)))
			  comment-list ",")))
      (weibo-get-data weibo-api-status-counts
		      'weibo-comment-parse-update-status (format "?ids=%s" ids) comment-list type))))

(defun weibo-comment-parse-update-status (root comment-list type)
  (when (string= (xml-node-name root) "counts")
    (let ((node-list (xml-node-children root))
	  (comment-alist (mapcar (lambda (comment)
				  `(,(weibo-status-id (weibo-comment-status comment))
				    . ,comment)) comment-list)))
      (mapc (lambda (node)
	      (let* ((id (weibo-get-node-text node 'id))
		     (comments (weibo-get-node-text node 'comments))
		     (rt (weibo-get-node-text node 'rt))
		     (acomment (assoc id comment-alist))
		     (comment (and acomment (cdr acomment))))
		(when comment (setf (weibo-status-comments (weibo-comment-status comment)) comments
				    (weibo-status-rt (weibo-comment-status comment)) rt))))
	    node-list))
    `(nil . ,comment-list)))

(defun weibo-comment-timeline-provider (key name data)
  (make-weibo-timeline-provider
   :key key
   :name name
   :make-function 'weibo-make-comment
   :pretty-printer-function 'weibo-comment-pretty-printer
   :pull-function 'weibo-pull-comment
   :post-function 'weibo-post-status
   :look-function 'weibo-look-comment-status
   :retweet-function nil
   :comment-function nil
   :reply-function 'weibo-reply-comment
   :header-function nil
   :update-function 'weibo-comment-update-status
   :data data))

(defun weibo-comments-by-me-timeline-provider ()
  (weibo-comment-timeline-provider "o" "发出评论" weibo-api-comments-by-me-timeline))

(defun weibo-comments-to-me-timeline-provider ()
  (weibo-comment-timeline-provider "c" "收到评论" weibo-api-comments-to-me-timeline))

(provide 'weibo-comment)