"""comment

Revision ID: 98ec2d615735
Revises: 227740127254
Create Date: 2024-04-11 11:17:07.882368

"""
from typing import Sequence, Union

import sqlalchemy as sa
from alembic import op

# revision identifiers, used by Alembic.
revision: str = "98ec2d615735"
down_revision: Union[str, None] = "227740127254"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column(
        "users", sa.Column("tel", sa.String(length=15), nullable=True, comment="電話番号")
    )
    # ### end Alembic commands ###


def downgrade() -> None:
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_column("users", "tel")
    # ### end Alembic commands ###