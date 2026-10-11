import os

import oracledb
from dotenv import load_dotenv

load_dotenv()

ORACLE_USER = os.getenv("ORACLE_USER")
ORACLE_PASSWORD = os.getenv("ORACLE_PASSWORD")
ORACLE_DSN = os.getenv("ORACLE_DSN")


def get_connection():
    """Create and return an Oracle database connection."""

    if not all([ORACLE_USER, ORACLE_PASSWORD, ORACLE_DSN]):
        raise RuntimeError(
            "Oracle configuration is incomplete. "
            "Check the backend .env file."
        )

    return oracledb.connect(
        user=ORACLE_USER,
        password=ORACLE_PASSWORD,
        dsn=ORACLE_DSN,
    )