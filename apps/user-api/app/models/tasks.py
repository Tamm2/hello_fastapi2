from common.database.model_mixins.user_mixins import TaskMixin
from config.settings import Base


class Task(Base, TaskMixin):
    __tablename__ = "tasks"
