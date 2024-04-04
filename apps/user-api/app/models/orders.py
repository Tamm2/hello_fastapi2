from common.database.model_mixins.order_mixins import OrderMixin
from config.settings import Base


class Order(Base, OrderMixin):
    __tablename__ = "orders"