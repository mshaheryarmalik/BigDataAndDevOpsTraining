import rds_config
import pymysql
#rds settings
rds_host  = "hamzadbinstance.crxlautcgczl.us-east-1.rds.amazonaws.com"
name = rds_config.db_username
password = rds_config.db_password
db_name = rds_config.db_name

try:
    conn = pymysql.connect(rds_host, user=name, passwd=password, db=db_name, connect_timeout=5)
except pymysql.MySQLError as e:
    print(e)
    
def lambda_function(event, context):
    """
    This function fetches content from MySQL RDS instance
    """

    item_count = 0

    with conn.cursor() as cur:
        cur.execute("SELECT * from world.city")  
        
    conn.commit()

    return "Added %d items from RDS MySQL table" %(item_count)
