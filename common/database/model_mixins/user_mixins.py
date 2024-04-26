from typing import TYPE_CHECKING

from sqlalchemy import BigInteger, Column, DateTime, String, text
from sqlalchemy.orm import Mapped, declarative_mixin, declared_attr, relationship

from django.db import models
from django.core.exceptions import ValidationError

if TYPE_CHECKING:
    from app.models.tasks import Task


@declarative_mixin
class UserMixin:
    id = Column(BigInteger, primary_key=True)
    name = Column(String(255), nullable=False, comment="名前")
    email = Column(String(255), nullable=False, unique=True, comment="メールアドレス")
    password = Column(String(255), nullable=False, comment="パスワード")
    created_at = Column(
        DateTime,
        nullable=False,
        server_default=text("CURRENT_TIMESTAMP"),
        comment="作成日時",
    )
    updated_at = Column(
        DateTime,
        nullable=False,
        server_default=text("CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP"),
        comment="更新日時",
    )
    tel = Column(String(15), unique=True,comment="電話番号")

    def clean(self):
        super().clean()
        if self.tel and (not self.tel.isdigit() or len(self.tel) < 10 or len(self.tel) > 11):
            raise ValidationError("電話番号は10桁または11桁の半角数字で入力してください。")

    class Meta:
        abstract = True


    @declared_attr
    def tasks(cls) -> Mapped["Task"]:
        return relationship("Task", backref="user")
