((org-mode . ((eval . (add-hook 'after-save-hook
                                (lambda () (org-latex-export-to-pdf t))
                                nil t)))))
