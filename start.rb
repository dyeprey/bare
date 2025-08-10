current_orientation = :north

$acceptable_orientations = [:n, :e, :s, :w]
$current_x_position = nil
$current_y_position = nil
$current_orientation = :n
command = ""

def place(initial_position)
  x, y, orientation = initial_position.split(',')

  if (x.nil? || x.empty? || y.nil? || y.empty? || orientation.nil? || orientation.empty?)
    puts 'Invalid placing arguments, Use "PLACE X,Y,ORIENTATION'
    return
  end

  if (x.to_i.negative? || y.to_i.negative?)
    puts "Values for X and Y should be 0-5"
    return
  end

  # Also fix the orientation check
  if (![:n, :e, :s, :w].include?(orientation.downcase.to_sym))
    puts "Allowed values for orientations are N, E, S, W"
    return
  end

  $current_x_position = x.to_i
  $current_y_position = y.to_i
  $current_orientation = orientation.to_s
end

def move
  if $current_x_position.nil? || $current_y_position.nil? || $current_orientation.nil?
    puts "Robot not placed, please place the robot by using the PLACE command"
    puts "Example: PLACE 0,0,N"
    return
  end

  case $current_orientation.downcase.to_sym
  when :n
    $current_y_position += 1 if $current_y_position < 5
  when :e
    $current_x_position += 1 if $current_x_position < 5
  when :s
    $current_y_position -= 1 if $current_y_position > 0
  when :w
    $current_x_position -= 1 if $current_x_position > 0
  end
  
end

def turn_left
  return if $current_orientation.nil? 
  current_index = $acceptable_orientations.index($current_orientation.downcase.to_sym)

  new_index = (current_index - 1) % $acceptable_orientations.length
  $current_orientation = $acceptable_orientations[new_index]

  case $current_orientation.downcase.to_sym
  when :n
    $current_orientation = :w
  when :e
    $current_orientation = :n
  when :s
    $current_orientation = :e
  when :w
    $current_orientation = :s
  end 
end

def turn_right
  return if $current_orientation.nil?

  case $current_orientation.downcase.to_sym
  when :n
    $current_orientation = :e
  when :e
    $current_orientation = :s
  when :s
    $current_orientation = :w
  when :w
    $current_orientation = :n
  end
end

def report
  puts "#{$current_x_position}, #{$current_y_position}, #{$current_orientation}"
end

while command != "report"
 begin
  user_input = gets.split(' ')
  command = user_input[0].downcase
  
  case command
  when 'place'
    place(user_input[1])
  when 'move'
    move
  when 'right'
    turn_right
  when 'left'
    turn_left
  when 'report'
    report
  else
    puts 'Command not supported'
  end
rescue => e
  "Something is wrong"
end
end
