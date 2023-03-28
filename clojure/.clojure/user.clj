(ns user
  (:require [portal.api :as p]))

(def p (p/open))
(add-tap #'p/submit)
