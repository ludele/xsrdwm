#!/bin/sh               

bluetooth(){

   bluetooth_devices="$(bluetoothctl devices Connected)"   
   check_connected="$(printf "$bluetooth_devices" | awk '{print $3}' | xargs)"

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
   fi

}

vol(){

getvol=`
         if [ $(pamixer --get-mute) = 'true' ]
         then
            :
         else
            pamixer --get-volume-human
         fi
       `

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

   printf "$emoji $getvol%\n"
}

network(){
   update(){
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=${XDG_CACHE_HOME:-$HOME/.cache}/${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf %d\\n "$sum" > "$cache"
    printf %d\\n $(( sum - old ))
   }

   rx=$(update /sys/class/net/[ew]*/statistics/rx_bytes)
   tx=$(update /sys/class/net/[ew]*/statistics/tx_bytes)

   printf "↓%4sB ↑%4sB\\n" $(numfmt --to=iec $rx) $(numfmt --to=iec $tx)
}


cpufreq(){
   awk '/MHz/ {print $4}' /proc/cpuinfo | xargs | awk '{print ($1+$2+$3+$4)/4 " MHz" }'
}

cputemp(){
   sensors | awk '/Core/ {print $3}' | cut -b 2,3,6,7 | xargs
}

ram(){
   free -h | awk '/Mem/ {print $3}'| sed 's/i/iB/'
}

# Called the time_date function for "date" 
# this causes date(){date};date which is almost a fork bomb

time_date(){
   date "+^c#6CC335^ %A %B %e ^c#FF90000^ %k:%M" | xargs
}

while xsetroot -name " \
\
^c#63a7d8^ `bluetooth`\
^c#B574C0^ `vol` \
^c#A787FF^ `network` \
^c#63AAFF^ `cputemp` \
^c#26BC91^ `ram` \
`time_date` \
"
do sleep 1 
done

