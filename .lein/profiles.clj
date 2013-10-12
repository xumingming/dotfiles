{:user {:plugins [[lein-ritz "0.7.0"]
                  [no-man-is-an-island/lein-eclipse "2.0.0"]
                  [jonase/eastwood "0.0.2"]]
        :dependencies [
                       [ritz/ritz-nrepl-middleware "0.7.0"]]
        :repl-options { ;;:init (use 'tracer.core)
                       :nrepl-middleware
                       [ritz.nrepl.middleware.javadoc/wrap-javadoc
                        ritz.nrepl.middleware.simple-complete/wrap-simple-complete]}}}