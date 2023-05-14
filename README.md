# Pawn Simulator

Ruby version : 2.7.6

# Dependencies

run `bundle install`

run `rspec ./spec`

# Local Testing

run `ruby lib/main.rb`

# Work Logs for reference

`ruby lib/main.rb`

 Enter your command:
'Place X,Y, North|South|East|West, White|Black ', Move, Left, Right, Report or Exit

`Place 5,5,north,white`

`true`

`move(2)`

`true`

`report`

`Current Position: 5,7,NORTH,WHITE`

`left`

`true`

`report`

`Current Position: 5,7,WEST,WHITE`

`move`

`true`

`report`

`Current Position: 4,7,WEST,BLACK`

`left`

`true`

`report`

`Current Position: 4,7,SOUTH,BLACK`

`move`

`true`

`report`

`Current Position: 4,6,SOUTH,WHITE`

`move`

`true`

`report`

`Current Position: 4,5,SOUTH,BLACK`

`left`

`true`

`report`

`Current Position: 4,5,EAST,BLACK`

`left`

`true`

`report`

`Current Position: 4,5,NORTH,BLACK`

`move`

`true`

`report`

`Current Position: 4,6,NORTH,WHITE`

`left`

`true`

`report`

`Current Position: 4,6,WEST,WHITE`

`report`

`Current Position: 4,6,WEST,WHITE`

`move`

`true`

`report`

`Current Position: 3,6,WEST,BLACK`

