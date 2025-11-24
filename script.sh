#!/bin/bash

#1.Sắp xếp các bộ phim theo ngày phát hành giảm dần rồi lưu ra một file mới
csvsort -c 16 -r normalize-movies.csv > sap-xep-theo-release-date.csv

#2.Lọc ra các bộ phim có đánh giá trung bình trên 7.5 rồi lưu ra một file mới
csvsql --query "SELECT * FROM movies WHERE CAST(vote_average AS FLOAT) > 7.5" --tables movies tmdb-movies.csv > luot-danh-gia-cao.csv

#3.Tìm ra phim nào có doanh thu cao nhất và doanh thu thấp nhất
csvsort -c 21 -r tmdb-movies.csv | tail -n +2 | awk -F, '{print $6}' | head -1
csvsort -c 21 -r tmdb-movies.csv | tail -n +2 | awk -F, '{print $6}' | tail -1

#4.Tính tổng doanh thu tất cả các bộ phim
awk -F, '{x+=$21}END{print x}' normalize-movies.csv 

#5.Top 10 bộ phim đem về lợi nhuận cao nhất
csvsort -c 21 -r tmdb-movies.csv | tail -n +2 | awk -F, '{print $6}' | head -10

#6.Đạo diễn nào có nhiều bộ phim nhất và diễn viên nào đóng nhiều phim nhất

#7.Thống kê số lượng phim theo các thể loại. Ví dụ có bao nhiêu phim thuộc thể loại Action, bao nhiêu thuộc thể loại Family, ….
