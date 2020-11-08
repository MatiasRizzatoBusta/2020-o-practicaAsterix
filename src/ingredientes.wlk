import pociones.*

class Ingrediente { //como tengo que agregar muchos con facilidad la hago clase
	
	method bonificacion(persona,pocion)
}

object dulceDeLeche inherits Ingrediente{
	override method bonificacion(persona,pocion){
		if(persona.fueraDeCombate()){
			persona.revivir(2)
		}else{
			persona.agregarFuerza(10)
		}
	}
}

class PuniadoDeHongos inherits Ingrediente{
	var hongosEnPuniado = []
	override method bonificacion(persona,pocion){
		const cantHongos = hongosEnPuniado.size()
		persona.agregarFuerza(cantHongos)
		if(cantHongos >= 5){
			persona.disminuirResistencia(2)
		}
	}
	
}


class Grog inherits Ingrediente{
	override method bonificacion(persona,pocion){
		persona.agregarFuerza(pocion.cantIngredientes())
	}
}

object grogXD inherits Grog{
	override method bonificacion(persona,pocion){
		super(persona,pocion)
		persona.aumentarResistencia(2)
	}
	
	
}
