(setq debug-on-error t
      debug-on-quit t
      ensime-log-events t
      ensime--debug-messages noninteractive
      ensime-typecheck-when-idle nil
      user-emacs-directory (expand-file-name
                            (concat ".cask/" emacs-version)))

;; can be useful when debugging the test framework
;; (add-hook 'kill-emacs-hook (lambda() (backtrace)))

;; Cask has downloaded everything for us
(require 'package)
(package-initialize)

;; enable coverage
(when (getenv "UNDERCOVER")
  (require 'undercover)
  (undercover "ensime*.el"
              (:report-file (expand-file-name "coveralls.json"))
              (:send-report nil)
              (:exclude "ensime-test.el" "dotemacs_test.el" "ensime-inspector.el")))

(add-to-list 'load-path default-directory)
(require 'ensime)
(require 'ensime-test)
(setq ensime-server-logback (concat ensime-test-dev-home "/test/logback.xml"))

(message "Using ensime-test-dev-home of %s" ensime-test-dev-home)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

;;; dotemacs_test.el ends here
