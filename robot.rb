current_orientation = :north

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

  # Array index starts at 0, so 6 is 5
  if (x.to_i > 5 || y.to_i > 5)
    puts "Values for X and Y should be 0-5"
    return
  end

  if (![:n, :e, :s, :w].include?(orientation.downcase.to_sym))
    puts "Allowed values for orientations are N, E, S, W"
    return
  end
  
  $current_x_position = x.to_i
  $current_y_position = y.to_i
  $current_orientation = orientation.downcase.to_sym
end

def check_placements
  if $current_x_position.nil? || $current_y_position.nil? || $current_orientation.nil?
    puts "Robot not placed, please place the robot by using the PLACE command"
    puts "Example: PLACE 0,0,N"
    return
  end
  true
end

def move
  return unless check_placements

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
  return unless check_placements

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
  return unless check_placements

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
  puts "#{$current_x_position}, #{$current_y_position}, #{$current_orientation.to_s.upcase}"
end

if __FILE__ == $0
  command = ""
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
    puts "Something is wrong"
  end
  end
end
