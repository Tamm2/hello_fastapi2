from datetime import datetime

from pytz import timezone  # type: ignore
from sqlalchemy import BigInteger, Column, DateTime, String,ForeignKey
from sqlalchemy.orm import declarative_mixin

from config.settings import TIME_ZONE


def current_timestamp():
    jst = timezone(TIME_ZONE)
    return datetime.now(jst)


"""
usersテーブル
id
email
password
name
created_at
updated_at


tasksテーブル
OK id
user_id ユーザーid, int nn, fk
OK title タイトル, varchar(255) nn
content 内容, text nn
deadlined_at 期限日時, datetime
completed_at 完了日時, datetime
created_at 作成日時, datetime, nn
updated_at 作成日時, datetime, nn
"""

@declarative_mixin
class TaskMixin:
    id = Column(BigInteger, primary_key=True)
    user_id = Column(BigInteger, ForeignKey("users.id"), nullable=False)
    title = Column(String(255), nullable=False, comment="タイトル")
    content = Column(String(255),nullable=False)
    deadlined_at = Column(DateTime)
    completed_at = Column(DateTime)
    created_at = Column(DateTime, nullable=False, default=current_timestamp)
    updated_at = Column(
        DateTime, nullable=False, default=current_timestamp, onupdate=current_timestamp
    )
