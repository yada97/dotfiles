function en --argument file
         emacsclient -nw $file
end
function store --argument path
         /run/media/yada/takashi/$path
end
function key
         set -x FZF_DEFAULT_OPTS ''
         eval $(keychain --eval --agents ssh --quiet --nogui $(fzf --walker-root=/home/yada/.ssh))
         fishrc
end
function fishrc
         source ~/.config/fish/config.fish
end
function ens --argument file
         sudo emacsclient -nw $file
end
#function floorp --argument browser
#         if [ "$browser" = "" ];
#            /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=floorp --file-forwarding one.ablaze.floorp
#          else
#            /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=floorp --file-forwarding one.ablaze.floorp $browser
#          end
#end

function proton --argument path path2
         protonvpn-cli $path $path2
end
function workdir --argument path
         if [ "$path" = "" ];
            cd /home/yada/Documents/WorkDir/
         else
            cd /home/yada/Documents/WorkDir/"$path"
         end

end
function gulag --argument path
         if [ "$path" = "" ];
            cd /home/yada/Documents/WorkDir/Gulag/
        else
            cd /home/yada/Documents/WorkDir/Gulag/"$path"
        end
end

function space --argument path
         if [ "$path" = "" ];
            cd /home/yada/Documents/WorkDir/Space/
        else
            cd /home/yada/Documents/Workdir/Space/"$path"
        end
end

function projects --argument path
         if [ "$path" = "" ];
            cd /home/yada/Documents/Projects/
         else
            cd /home/yada/Documents/Projects/"$path"
        end
end
function source_fishrc
         source /home/yada/.config/fish/config.fish
end

function pent --argument program
         if [ "$program" = "" ];
            echo "program cannot be empty"
         else
             set loc $(pwd)
             cd /home/yada/Documents/WorkDir/Gulag/Templates/pen-notes/pen-notes && git worktree add $program
             mv $program $loc && cd $loc
         end
end

function blip --argument lip
         if [ "$lip" = "" ];
            echo $(pwd) | xclip -sel clip

         else
            cd $(xclip -o)

         end
end
