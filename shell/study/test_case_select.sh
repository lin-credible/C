PS3="Please select:"
select var in "Linux" "Unix" "Macos" "Windows" "Quit"
do
	case $var in
	Linux)
		echo "Your choice is Linux~"
		;;
	Unix)
		echo "Your choice is Unix~"
		;;
	Macos)
		echo "Your choice is Macos~"
		;;
	Windows)
		echo "Your choice is Windows~"
		;;
	Quit)
		exit 0
		;;
	*)
		echo "Your choice is Wrong~"
		;;
	esac
done
