import cosas.*
//Camión

object camion {
  const cosasCargadas = []

  method cargarCosa(cosa) { cosasCargadas.add(cosa) }
  method descargarCosa(cosa) { cosasCargadas.remove(cosa) }

  method peso() = 1000 + self.pesoDeLaCarga()
  method pesoDeLaCarga() = cosasCargadas.sum({ c => c.peso() })
  method cargaPesosPares() = cosasCargadas.all({ c => c.peso().even() })
  method seCargaAlgoConPesoIgualA(peso) = cosasCargadas.any({ c => c.peso() == peso })
  method primerCargaConPeligrosidadIgualA(peligrosidad) = cosasCargadas.findOrDefault({ c => c.nivelDePeligrosidad() == peligrosidad }, "No hay")
  method cargasConPeligrosidadMayorQue(peligrosidad) = cosasCargadas.filter({ c => c.nivelDePeligrosidad() > peligrosidad })
  method cargasConPeligrosidadMayorQuePeligrosidadDe(cosa) = cosasCargadas.filter({ c => c.nivelDePeligrosidad() > cosa.nivelDePeligrosidad() })
  method estaExcedidoDePeso() = self.peso() > 2500
  method puedeCircularEnRutaConNivelPeligrosidadMaximoDe(peligrosidad) = !self.estaExcedidoDePeso() and self.cargasConPeligrosidadMayorQue(peligrosidad).isEmpty()
  method cargaCosaQuePesaEntre(min, max) = cosasCargadas.any({ c => c.peso().between(min, max) })
  method cargaMásPesada() = cosasCargadas.max({ c => c.peso() })
}

//Cosas

object knightRider {
  method peso() = 500
  method nivelDePeligrosidad() = 10
  method bultosComoCarga() = 1
  method serCargada() { }
}

object bumblebee {
  var esAuto = true

  method peso() = 800
  method nivelDePeligrosidad() = if (esAuto) 15 else 30
  method transformarse() { esAuto = !esAuto }
  method bultosComoCarga() = 2
  method serCargada() { esAuto = false }
}

object paqueteDeLadrillos {
  var cantidadDeLadrillos = 0
  
  method peso() = 2 * cantidadDeLadrillos
  method nivelDePeligrosidad() = 2
  method cambiarCantidadLadrillos(cantidad) { cantidadDeLadrillos = cantidad }
  method bultosComoCarga() = if (cantidadDeLadrillos <= 100 ) { 1 } else if (cantidadDeLadrillos <= 300) { 2 } else 3 
  method serCargada() { cantidadDeLadrillos += 12 }
}

object arenaAGranel {
  var property peso = 0
  
  method nivelDePeligrosidad() = 1
  method bultosComoCarga() = 1
  method serCargada() { peso = 0.max(peso-10) }
}


object bateriaAntiaerea {
  var estaConMisiles = false
  
  method peso() = if (estaConMisiles) 300 else 200
  method nivelDePeligrosidad() = if (estaConMisiles) 100 else 0
  method cargarYDescargarMisiles() { estaConMisiles = !estaConMisiles }
  method bultosComoCarga() = if (!estaConMisiles) 1 else 2
  method serCargada() {  estaConMisiles = true }
}

object contenedorPortuario {
  const cosasContenidas = []

  method peso() = 100 + cosasContenidas.sum({ c => c.peso() })
  method nivelDePeligrosidad() = self.cosaMasPeligrosa().peso()
  method cosaMasPeligrosa() = cosasContenidas.max({ c => c.peso() })
  method bultosComoCarga() = 1 + self.bultosDeLoQueContiene()
  method bultosDeLoQueContiene() = cosasContenidas.sum({ c => c.bultosComoCarga() })
  method serCargada() { cosasContenidas.forEach({ c => c.serCargada() }) }
}

object residuos {
  var property peso = 0

  method nivelDePeligrosidad() = 200 
  method bultosComoCarga() = 1
  method serCargada() { peso += 15 }
}

object embalaje {
  var objetoEnvuelto = bateriaAntiaerea

  method peso() = objetoEnvuelto.peso()
  method nivelDePeligrosidad() = objetoEnvuelto.nivelDePeligrosidad() * 0.5
  method envolverCosa(cosa) { objetoEnvuelto = cosa }
  method bultosComoCarga() = 2
  method serCargada() { }
}