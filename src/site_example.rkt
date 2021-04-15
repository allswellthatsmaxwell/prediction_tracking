#lang web-server/insta

(struct prediction (text number))

(define PREDICTIONS
  (list
   (prediction "This album is more than 30 minutes long" "60")
   (prediction "It's after 11pm right now"  "30")
   (prediction "K will dye her hair pink or purple in the next 6 months" "55")))
 
; start: request -> response
; Consumes a request, and produces a page that displays all of the
; web content.
(define (start request)
  (render-blog-page PREDICTIONS request))
 
; render-blog-page: blog request -> response
; Consumes a blog and a request, and produces an HTML page
; of the content of the blog.
(define (render-blog-page a-blog request)
  (response/xexpr
   `(html (head (title "My Blog"))
          (body (h1 "My Blog")
                ,(render-posts a-blog)))))
 
; render-post: prediction -> xexpr
; Consumes a post, produces an xexpr fragment of the post.
(define (render-post a-post)
  `(div ((class "prediction"))
        ,(prediction-text a-post)
        (p ,(prediction-number a-post))))
 
; render-posts: blog -> xexpr
; Consumes a blog, produces an xexpr fragment
; of all its posts.
(define (render-posts a-blog)
  `(div ((class "posts"))
        ,@(map render-post a-blog)))