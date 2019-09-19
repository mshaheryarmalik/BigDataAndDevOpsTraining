import rds_config
import pymysql
#rds settings
rds_host  = "hamzadbinstance.crxlautcgczl.us-east-1.rds.amazonaws.com"
name = rds_config.db_username
password = rds_config.db_password
db_name = rds_config.db_name

try:
    conn = pymysql.connect(rds_host, user=name, passwd=password, db=db_name, connect_timeout=10)
except pymysql.MySQLError as e:
    print(e)
    
def lambda_handler(event, context):
    """
    This function gets data from Country Table using RDS instance
    """

    item_count = 0

    with conn.cursor() as cur:
        cur.execute("SELECT * from world.country")
        countries = cur.fetchall()
        
    conn.commit()

    return countries
