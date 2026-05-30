reset

#グラフ設定
set terminal pngcairo size 500,500      #1000×1000。自由に変更可

set output '../imageout/epsilon.png'                   #output.pngに出力。自由に変更可。
#set title'Title'                          #Title：グラフのタイトル。グラフ上側に表示

set xlabel 'Δx'              #quantity [unit]：x軸の物理量[単位]
set xrange [5.1035156250000000E-005:0.60000000000000000 ]                          #xの表示幅
#set xtics 0.1                             #xのメモリ幅

set ylabel 'ε'              #quantity [unit]：y軸の物理量[単位]
#set yrange [0:1]                          #yの表示幅
#set ytics 0.1                             #yのメモリ幅

set logscale xy

set key top left                     #keyの位置。top/bottom/outside right/left
#set key spacing 1.2
set key reverse Left
#set key offset 1,0  
#set key spacing 1.2
#set key reverse Left

#その他の設定(optional)

#unset xtics                              #メモリ消す
#set xtics scale 0                        #メモリのラベルだけ消す
#set xtics add (0.2)                      #(0.2)の位置にメモリを挿入する


#set parametric                           #縦線を引きたいとき：set setparametric
#set trange [0:1]                         #縦線を引きたいとき：set trange[min_y:max_y]

#set border lw 0.5 lc rgb "gray"          #軸の線の設定
set format x "%.1t×10^{%L}"
set format y "%.1t×10^{%L}"

#グラフ中のラベル・線分(optional)

#set label "hoge" at 0.5,0.5              #0.5,0.5にhogeの文字を表示させる。
#set arrow 1 from 0,1 to 1,0 nohead       #0,1から1,0に線分 lw等の設定可

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

#プロット

f(x) = x
g(x) = x**2.0


plot \
for [p=-2:4:2] 10.0**p*f(x) with lines dt 2 lc rgb c8 lw 0.8 notitle, \
for [p=1:7:2] 10.0**p*g(x) with lines dt 3 lc rgb c5 lw 0.8 notitle, \
'../dataout/epsilon.dat' using 2:3 every ::1 with linespoints lc rgb c2 lw 1.5 pt 7 title '1st order upwind', \
'../dataout/epsilon.dat' using 2:4 every ::1 with linespoints lc rgb c3 lw 1.5 pt 7 title 'Lax-Wendroff',\
1e-4*f(x) with lines dt 2 lc rgb c8 lw 0.8 title '∝ Δx', \
1e0*g(x) with lines dt 3 lc rgb c5 lw 0.8 title '∝ Δx^{2}'

#'./out2.dat' using 1:2 every ::0 with points lc 'black' ps 1 title 'graph2' ,\
#0.5,t with lines lc 'black' lt 0 title 'vertical line' ,\
#'+' using (0):(1) with points pt 6 lc 'red' title 'point' 

#lc=linecolor,lw=linewidth,lt=linetype,pt=pointtype,ps=pointsize
#縦線；(x),t with lines …
#点：'+' using (x):(y) with points
#破線:　dashtype 2 …





