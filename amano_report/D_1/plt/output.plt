reset

# fortranファイルの出力を見て、ここを書き換えること！
    first_filenum = 0
    last_filenum = 750
#


set xrange [0:1]
set xtics 0.2
set xlabel "x"
set ytics 0.5
set ylabel "u"
set grid 
#set key top right                         
#set key spacing 1.2
set key reverse Left
set key offset 1,-2 
#set key spacing 1.2
#set key reverse Left
set terminal pngcairo size 500,500 

# 色（Okabe-Ito系）
c1 = "#000000"   # black
c2 = "#0072B2"   # blue
c3 = "#D55E00"   # vermillion
c4 = "#009E73"   # bluishgreen
c5 = "#E69F00"   #orange
c6 = "#CC79A7"   #reddishpurple
c7 = "#F0E442"   #yellow
c8 = "#56B4E9"   #skyblue
c9 = "#999999"   #gray

t=0


do for [n=first_filenum:last_filenum]{

    imageout_name = sprintf("../imageout/image%06d.png", n)
    file_in_name = sprintf("../dataout/%06d.dat", n)
    set output imageout_name                  #output.pngに出力。自由に変更可。
    set yrange [*:*]
    stats file_in_name using 1 every ::1::2 nooutput
    t = STATS_min
    set label 1 sprintf("t = %.4f", t) at graph 0.95, 0.95 right front
    set yrange [-2:2]
    plot\
    file_in_name using 2:3 every ::1 with lines lc 'black' lw 1 title 'exact solution',\
    file_in_name using 2:4 every ::1 with lines lc rgb c2 lw 1 title '1st order upwind',\
    file_in_name using 2:5 every ::1 with lines lc rgb c3 lw 1 title 'Lax-Wendroff'
    print t
}



#プロット



#'./out2.dat' using 1:2 every ::0 with points lc 'black' ps 1 title 'graph2' ,\
#0.5,t with lines lc 'black' lt 0 title 'vertical line' ,\
#'+' using (0):(1) with points pt 6 lc 'red' title 'point' 

#lc=linecolor,lw=linewidth,lt=linetype,pt=pointtype,ps=pointsize
#縦線；(x),t with lines …
#点：'+' using (x):(y) with points
#破線:　dashtype 2 …





