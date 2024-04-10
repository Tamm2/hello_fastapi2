from sqlalchemy import BigInteger, Column, DateTime, ForeignKey, String, text
from sqlalchemy.orm import declarative_mixin


@declarative_mixin
class TaskMixin:
    id = Column(BigInteger, primary_key=True)
    user_id = Column(BigInteger, ForeignKey("users.id"), nullable=False)
    title = Column(String(255), nullable=False, comment="タイトル")
    content = Column(String(3000), nullable=False)
    deadline_at = Column(DateTime)
    completed_at = Column(DateTime)
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
