extends KinematicBody
var velocity = Vector3() #Говорит движке о пространстве и о том где находится обьект и о его скорости
const SPEED = 5.0 #Скорость
const JUMP_VELOCITY = 4.5 #сила прыжка

#Сила гравитации 
var gravity = 9.8


func _physics_process(delta):
	# добавляем гравитацию
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# реализация прыжка с помошью кнопки пробел
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Получаем данные о том нажимает ли игрок на клавиши движения в рахные стороны
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#немного вычислений для опредиления направления нашего игрокаи его нормализации
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	#реализация движения игрока по всем осям
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	move_and_slide(velocity, Vector3.UP, true) #метод который используя данные о том как движется объект опредиляет как он сталкивается
	
