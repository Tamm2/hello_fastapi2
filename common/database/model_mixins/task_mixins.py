from datetime import datetime

from pytz import timezone  # type: ignore
from sqlalchemy import BigInteger, Column, DateTime, String,ForeignKey
from sqlalchemy.orm import declarative_mixin

from config.settings import TIME_ZONE


def current_timestamp():
    jst = timezone(TIME_ZONE)
    return datetime.now(jst)


@declarative_mixin
class TaskMixin:
    id = Column(BigInteger, primary_key=True)
    user_id = Column(BigInteger, ForeignKey("users.id"), nullable=False)
    title = Column(String(255), nullable=False, comment="タイトル")
    content = Column(String(3000),nullable=False,comment="内容")
    deadlined_at = Column(DateTime)
    completed_at = Column(DateTime)
    created_at = Column(DateTime, nullable=False, default=current_timestamp)
    updated_at = Column(
        DateTime, nullable=False, default=current_timestamp, onupdate=current_timestamp
    )
