from AT_menu import Menu

class Preco(Menu):
    def __init__(self, id_tarifa, id_reserva, preco_manual=None):
        self._id_tarifa = id_tarifa
        self._id_reserva = id_reserva
        self._preco_manual = preco_manual

    @property
    def id_tarifa(self):
        return self._id_tarifa

    @id_tarifa.setter
    def id_tarifa(self, value):
        if not isinstance(value, int):
            raise ValueError("ID Tarifa must be an integer.")
        self._id_tarifa = value

    @property
    def id_reserva(self):
        return self._id_reserva

    @id_reserva.setter
    def id_reserva(self, value):
        if not isinstance(value, int):
            raise ValueError("ID Reserva must be an integer.")
        self._id_reserva = value

    @property
    def preco_manual(self):
        return self._preco_manual

    @preco_manual.setter
    def preco_manual(self, value):
        if value is not None and not isinstance(value, float):
            raise ValueError("Preco Manual must be a float or None.")
        self._preco_manual = value

    def __str__(self):
        return f"Preco(id_tarifa={self.id_tarifa}, id_reserva={self.id_reserva}, preco_manual={self.preco_manual})"
