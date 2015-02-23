Great East Japan Earthquake Evacuees. Data are sourced from Japan's Reconstruction Agency. Two series are provided in this Data Package: monthly totals and monthly totals by prefecture.

[![Build Status](https://travis-ci.org/hhtyo/great-east-japan-earthquake-evacuees.png)](https://travis-ci.org/hhtyo/great-east-japan-earthquake-evacuees)

## Background

The inspiration for extracting these data came from a comment and a [visualization](http://www3.nhk.or.jp/nhkworld/newsline/path_to_recovery/post-disaster_recovery_in_numbers.pdf) shared by [NHK News Web](http://www3.nhk.or.jp/news/) developer Satoshi Yamamoto in the [European Journalism Centre](http://ejc.net/)'s [Doing Journalism with Data](http://datajournalismcourse.net/) MOOC.

## Data

### Description

[Great East Japan Earthquake evacuees](http://www.reconstruction.go.jp/topics/main-cat2/sub-cat2-1/hinanshasuu.html) by prefecture, compiled by Japan's [Reconstruction Agency](http://www.reconstruction.go.jp/), and originally published as [PDF files](https://github.com/hhtyo/great-east-japan-earthquake-evacuees/tree/master/archive/pdf).

## Data Preparation

### Processing

Run the following script from this directory to download and process the data:

```bash
make data
```

### Processing Notes

**Extraction**

[`tabula-extractor`](https://github.com/jazzido/tabula-extractor), an [Apache PDFBox](http://pdfbox.apache.org/)-powered, [JRuby](http://jruby.org/)  "table extraction engine", is used to extract the title, date, and evacuees by prefecture data from pages three to five of each file.

**Transformation**

In the intermediate CSVs, column totals and calculated changes in evacuee numbers are deleted. The first column, which has prefecture IDs and names, is split into two columns: [ISO 3166-2:JP](http://en.wikipedia.org/wiki/ISO_3166-2:JP) codes and prefecture names. Any notes that were in a table cell are in a new column at the end of the same row. Lastly, the data date is appended to the end of the each row. Missing or empty values are marked with 'NA'.

### Resources

The original PDFs are downloaded to `./archive/pdf`, the extracted PDFs are output to `./archive/csv`, and the processed data are output to `./data`.

## License

### ODC-PDDL-1.0

These data are made available under the Public Domain Dedication and License v1.0 whose full text can be found at: http://www.opendatacommons.org/licenses/pddl/1.0/
