;; Copyright 2018 Zach Flynn
;; Licensed under the 3-clause BSD license, included as the file COPYING in this repository or
;; available online at: https://opensource.org/licenses/BSD-3-Clause

(use-modules (ice-9 regex))
(use-modules (ice-9 textual-ports))
(define header-regex "\\\\\\\\HEADER")
(define footer-regex "\\\\\\\\FOOTER")
(define google-analytics-regex "\\\\\\\\ANALYTICS")

(define page-list
  (list "index" "research" "teaching" "programs" "links" "102" "310"))

(map
 (lambda (page)

   (define file
     (string-append page ".html"))

   (define src
     (string-append page ".pre.html"))

   (define header-text
     "<h1>Zach Flynn</h1>\n
  <hr>\n
  <a href=\"index.html\">Home</a>\n
  <a href=\"research.html\">Research</a>\n
  <a href=\"teaching.html\">Teaching</a>\n
  <a href=\"programs.html\">Programs</a>\n
  <a href=\"links.html\">Links</a>\n
  <a href=\"https://medium.com/@zlflynn\">Blog</a>\n
  <hr>\n
  <a href=\"https://github.com/flynnzac/cv/raw/master/cv.pdf\">Curriculum Vitae</a>\n
  <address>\n
    Email: <a href=\"mailto:zlflynn@gmail.com\">zlflynn@gmail.com</a>\n
  </address>\n
  <hr>\n")

   (define footer-text
     (string-append "\n<hr>\nThis site last update: "
                    (strftime "%c" (localtime (current-time)))
                    "\n<br>Copyright 2018 Zach Flynn."))

   (define google-analytics-text
     "<!-- Global site tag (gtag.js) - Google Analytics -->\n
<script async src=\"https://www.googletagmanager.com/gtag/js?id=UA-59441513-2\"></script>\n
<script>\n
  window.dataLayer = window.dataLayer || [];\n
  function gtag(){dataLayer.push(arguments);}\n
  gtag('js', new Date());\n
\n
  gtag('config', 'UA-59441513-2');\n
</script>")

   


   (define regex-text
     (string-append "<a href=\\\""
                    file
                    "\\\">([a-zA-Z]+)</a>"))


   (define main-text (get-string-all (open-file src "r")))
   (let ((cur-match (string-match regex-text header-text)))
     (if cur-match
         (set! header-text
           (regexp-substitute #f cur-match 'pre
                              (string-append "<b><a href=\"" file "\">") 1 "</a></b>\n" 'post))))





   (set! main-text
     (regexp-substitute #f (string-match header-regex main-text)
                        'pre
                        header-text
                        'post))

   (set! main-text
     (regexp-substitute #f (string-match footer-regex main-text)
                        'pre
                        footer-text
                        'post))

   (set! main-text
     (regexp-substitute #f (string-match google-analytics-regex main-text)
                        'pre
                        google-analytics-text
                        'post))

   
   (let ((output-port (open-file file "w")))
     (display main-text output-port)
     (close-port output-port)))
 page-list)




