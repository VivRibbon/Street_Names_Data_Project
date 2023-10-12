(defproject street_data_cleaning "0.1.0-SNAPSHOT"
  :description "Simple data cleaning to port into R for data analysis project"
  :url "https://github.com/VivRibbon/Street_Names_Data_Project"
  :license {:name "MIT"
            :url "https://mit-license.org/"}
  :dependencies [[org.clojure/clojure "1.11.1"] [org.clojure/data.csv "1.0.1"] [clojure-interop/java.io "1.0.5"]]




  :repl-options {:init-ns street-data-cleaning.core}
  :main street-data-cleaning.core/main)
