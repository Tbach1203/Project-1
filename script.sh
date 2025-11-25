#!/bin/bash

#1.Sắp xếp các bộ phim theo ngày phát hành giảm dần rồi lưu ra một file mới
csvsort -c 16 -r tmdb-movies.csv > sap-xep-theo-release-date.csv

#2.Lọc ra các bộ phim có đánh giá trung bình trên 7.5 rồi lưu ra một file mới
csvsql --query "SELECT * FROM movies WHERE CAST(vote_average AS FLOAT) > 7.5" --tables movies tmdb-movies.csv > luot-danh-gia-cao.csv

#3.Tìm ra phim nào có doanh thu cao nhất và doanh thu thấp nhất
echo "Phim co doanh thu cao nhat: $(csvsort -c 5 -r tmdb-movies.csv | tail -n +2 | awk -F, '{print $6}' | head -1)"

csvgrep -c 5 -r '^[1-9].*' tmdb-movies.csv| csvsort -c 21 -r | awk -F, '{print $6}' | tail -1

#4.Tính tổng doanh thu tất cả các bộ phim
awk -F, '{x+=$5}END{print x}' normalize-movies.csv 

#5.Top 10 bộ phim đem về lợi nhuận cao nhất
csvsort -c 5 -r tmdb-movies.csv | tail -n +2 | awk -F, '{print $6}' | head -10

#6.Đạo diễn nào có nhiều bộ phim nhất và diễn viên nào đóng nhiều phim nhất
awk -F, '{
    split($9, a, "|");
    for(i in a) {
        if(a[i] != "") print a[i];
    }
}' normalize-movies.csv | sort | uniq -c | sort -nr | head -1 | awk '$1 = ""; sub(/^ /,""); {print }'

awk -F, '{split($7, a, "|");for(i in a) {if(a[i] != "") print a[i];}}' normalize-movies.csv | sort | uniq -c | sort -nr | head -1 | awk '$1 = ""; {print }'

#7.Thống kê số lượng phim theo các thể loại. Ví dụ có bao nhiêu phim thuộc thể loại Action, bao nhiêu thuộc thể loại Family, ….
awk -F, '{split($14, a, "|");for(i in a) {if(a[i] != "") print a[i];}}' normalize-movies.csv | tail -n+2| sort | uniq -c | sort -nr
