
class Duck
    def shout
        puts 'Gagaga...'
    end
    def swim
        puts 'Duck swimming'
    end
end

class Frog
    def shout
        puts 'Guagua...'
    end
    def swim
        puts 'Frog swimming'
    end
end

def shoutAndSwim(duck)
    duck.shout
    duck.swim
end

shoutAndSwim(Duck.new)
shoutAndSwim(Frog.new)
        
