Set-Location -Path "D:\实用脚本"
convert -density 500 -units PixelsPerInch  -quality 100 -alpha remove \ "D:\实用脚本\wallpaper.pdf"  ./wallpaper.jpg

# Quality 这个为转换图片时的压缩率，0-100之间，默认是80%，我这里指定100%，最佳质量。
# -units PixelsPerInch：指定单位，这个配合-density使用，指定-density的单位，这个很重要啊，我发现有些图片的解析度单位是centimeter，这两个单位差得还是比较远的。