(ns street-data-cleaning.core
  (:require [clojure.data.csv :as csv])
  (:require [clojure.java.io :as io]))

(defn csv-data->maps
  "Basic function that turns csv data into a vector of hash maps"
  [csv-data]
  (map zipmap
       (->> (first csv-data)
            (map keyword)
            repeat)
       (rest csv-data)))

(defn maps->csv-data
  "Reverses the conversion process, turning a list of maps back into CSV data."
  [maps]
  (let [columns (-> maps first keys)
        headers (mapv name columns)
        rows (mapv #(mapv % columns) maps)]
    (into [headers] rows)))


(defn process-csv
  "Data cleaning function. An originating file and destination file are consumed by the io/reader. The threading operator is used to put the read file through a processing pipeline which takes the CSV data from the reader, turns it into a list of maps, retains only those streets named after a person, removes a number of columns that aren't relevant, converts the processed maps back into CSV data, and writes it to the destination file."
  [from to]
  (with-open [reader (io/reader from)
              writer (io/writer to)]
    (->> (csv/read-csv reader)
         (csv-data->maps)
         (filter #(= (:person %) "1"))
         (map #(select-keys % [:lau_name :country :street_name
                               :named_after_n :label :instance_of_label
                               :description :gender
                               :occupation_label :occupation_category
                               :date_of_birth :place_of_birth_label :place_of_death_label
                               :country_of_citizenship :wikipedia]))
         (maps->csv-data)
         (csv/write-csv writer))))

(defn main []
  (process-csv "orig_data.csv" "processed_data.csv"))



(main)
