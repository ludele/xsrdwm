#!/usr/bin/env ruby

def bluetooth

x = `bluetooth_devices="$(bluetoothctl devices Connected)"
   check_connected="$(printf "$bluetooth_devices"\
      | awk '{print $3}'\
      | xargs)"

   if [ -z "$bluetooth_devices" ]
   then
      :

   elif [ $check_connected = "Soundcore" ]
   then
      printf "\n"

   elif [ $check_connected = "Xbox" ]
   then
      printf "🎮\n"

   elif [ $check_connected = "PG-9028" ]
   then
      printf "👾\n"

   elif [ "$check_connected" = "Xbox Soundcore" ]
   then
      printf "🎮 \n"

   elif [ "$check_connected" = "PG-9028 Soundcore" ]
   then
      printf "👾 \n"

   elif [ "$check_connected" = "Xbox PG-9028" ]
   then
      printf "🎮 👾\n"

   elif [ "$check_connected" = "Xbox PG-9028 Soundcore" ]
   then
      printf "🎮 👾 \n"
   else
      printf "$check_connected"
   fi`
   x = "^c#63a7d8^ #{x}"
   x.delete!("\r\n\\")

end


def vol

x = `getvol=$(
   if [ $(pamixer --get-mute) = 'true' ]
   then
   :
   else
   pamixer --get-volume-human
   fi)

  rawvol=$(printf "$getvol"\n)

   if [ $rawvol -gt 100 ]
   then
      emoji=""

   elif [ $rawvol -gt 70 ]
   then
      emoji=""

   elif [ $rawvol -gt 50 ]
   then
      emoji="🔉"

   elif [ $rawvol -gt 0 ]
   then
      emoji="🔈"
   else
      emoji="🔇"
   fi

   printf "$emoji $getvol%\n"`
   x = "^c#B574C0^ #{x}"
   x.delete!("\r\n\\")

end


def network

  x = `net`
  x = "^c#A787FF^ #{x}"
  x.delete!("\r\n\\")

end


def cputemp

  x = `sensors\
      | awk '/Core/ {print $3}'\
      | cut -b 2,3,6,7\
      | xargs`
  x = "^c#63AAFF^ #{x}"
  x.delete!("\r\n\\")

end


def ram

  x = `free -h\
      | awk '/Mem/ {print $3}'\
      | sed 's/i/iB/'`
  x = "^c#26BC91^ #{x}"
  x.delete!("\r\n\\")

end

def time

  Time.now.strftime\
  ("^c#6CC335^ %A %B %e ^c#D25050^ %k:%M:%S")

end

while true

  system("xsetroot -name '\
  #{bluetooth}#{vol} #{network} #{cputemp} #{ram} #{time} '")
 
  `sleep 1`
 
end
