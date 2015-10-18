echo hello; echo there

if [ -x "$filename" ]; then 	#注意: "if"和"then"需要分隔
				#为什么？
	echo "File $filename exists."; cp $filename
