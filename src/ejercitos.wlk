import personas.*

class Ejercito{
	var integrantes = []
	var poder = 0
	var cantidadDelantera = 10
	
	method agregarIntegrante(integrante) = integrantes.add(integrante)
	
	method integrantes() = integrantes
	
	method cambiarCantDelantera(nuevaCant){
		cantidadDelantera = nuevaCant
	}
	
	method poder(){
		poder = self.calculoPoder()
		return poder
	}
	
	method calculoPoder(){
		const integrantesVivos = integrantes.filter({integrante => not(integrante.fueraDeCombate())})
		return integrantesVivos.sum({integrante => integrante.poder()})
	}
	
	method cambiarPoder(nuevoPoder){
		poder = nuevoPoder
	}
	
	method losMasPoderosos() = integrantes.sortedBy({integrante,otroIntegrante => integrante.poder() > otroIntegrante.poder()})
	
	method recibirDanio(danio){
		const danioEquitativo = danio / integrantes.size()
		if(integrantes.size() <= cantidadDelantera){
			integrantes.forEach({integrante => integrante.recibirDanio(danioEquitativo)})
		}else{
			const primerosX = self.losMasPoderosos().take(cantidadDelantera)
			primerosX.forEach({integrante => integrante.recibirDanio(danioEquitativo)})
		}
	}
	
	method fueraDeServicio() = integrantes.all({integrante => integrante.fueraDeCombate()})
	
	method luchar(contrincante){
		if(self.fueraDeServicio()){
			self.error("Todos estan fuera de servicio")
		}else{
		const menosPoderoso = self.losMasPoderosos().last() 
		const diferenciaPoder = self.poder() - contrincante.poder()
		menosPoderoso.recibirDanio(diferenciaPoder)
		
		}
	}
}

class Legion inherits Ejercito{ //polimorfico con ejercito
	var formacion
	const minimo = 20
	
	method cambiarFormacion(nuevaFormacion){
		formacion = nuevaFormacion
	}
	
	override method recibirDanio(danio){
		super(danio)
		if(self.poder() < minimo){
			formacion = tortuga
		}
	}
	
	override method luchar(contrincante){
		formacion.comportamientoLegion(self,contrincante.poder())	
	}
	
}

class Formacion{
	
	method comportamientoLegion(legion,danio){
		legion.recibirDanio(danio)
	}
	
}

object tortuga inherits Formacion{
	
	override method comportamientoLegion(legion,danio){
		legion.cambiarPoder(0)
		super(legion,0)
	}
	
}

class EnCuadro inherits Formacion{
	var integrantesQueVanAdelante
	
	override method comportamientoLegion(legion,danio){
		legion.cambiarCantDelantera(integrantesQueVanAdelante)
		super(legion,danio)
	}
	
}

object fontemAllargate inherits Formacion{
	override method comportamientoLegion(legion,danio){
		legion.calculoPoder() 
		legion.cambiarPoder(legion.poder() * 1.1)
		const mitadLegion = legion.losMasPoderosos().take(legion.integrantes().size() / 2)
		legion.cambiarCantDelantera(mitadLegion.size())
		super(legion,danio *2)
	}
	
}

const enCuadro1 = new EnCuadro(integrantesQueVanAdelante = 20)
const legion1 = new Legion(formacion = enCuadro1)
