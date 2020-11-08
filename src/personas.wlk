import pociones.*

class Persona {
	var resistencia = 1
	var fuerza = 1
	
	
	method fueraDeCombate() = resistencia == 0
	
	method resistencia() = resistencia
	
	method fuerza() = fuerza
	
	method revivir(resistenciaNueva){
		resistencia = resistenciaNueva
	}
	
	method aumentarResistencia(aumento){
		resistencia *= aumento
	}
	
	method disminuirResistencia(disminucion){
		resistencia /= disminucion
	}
	
	method agregarFuerza(aumento){
		fuerza += aumento
	}
	
	method poder() = self.fuerza() * self.resistencia()
	
	method recibirDanio(danio){
		const resistenciaDespuesDeAtaque = 0.max(resistencia - danio)
		resistencia = resistenciaDespuesDeAtaque
	}
	
	method tomarPocion(pocion) = pocion.aplicarEfecto(self)
	
}