{:user {:plugins [[lein-ritz "0.7.0"]]
        :dependencies [
                       [ritz/ritz-nrepl-middleware "0.7.0"]]
        :repl-options { ;;:init (use 'tracer.core)
                       :nrepl-middleware
                       [ritz.nrepl.middleware.javadoc/wrap-javadoc
                        ritz.nrepl.middleware.simple-complete/wrap-simple-complete]}}}