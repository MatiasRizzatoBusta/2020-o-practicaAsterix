import personas.*
import ingredientes.*

class Pocion {
	var ingredientes = []
	
	method ingredientes() = ingredientes
	
	method cantIngredientes() = ingredientes.size()
	
	
	method agregarIngrediente(ingrediente){
		ingredientes.add(ingrediente)
	}
	
	method aplicarEfecto(persona) = ingredientes.forEach({ingrediente => ingrediente.bonificacion(persona,self)})
	
}
