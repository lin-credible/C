class Cock
    def shout
        puts 'Cock wowowo...'
    end
end

class Fish
    def swim
        puts 'Fish swimming...'
    end
end

def shoutOrSwim(duck, flag)
    flag ? duck.shout : duck.swim
end

shoutOrSwim(Cock.new, true)
shoutOrSwim(Fish.new, false)
