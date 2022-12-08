import time
from datetime import datetime, timedelta

def lambda_handler(event, context):
    now = datetime.today()


    time_plus_15 = now + timedelta(minutes=17)
    print(time_plus_15)
    print("Execution started !!!!")
    
    while now < time_plus_15 :
        print("Running .......")
        time.sleep(5)
        now = datetime.today()
        delta = time_plus_15 - now
        print(f"Time remaining {delta.total_seconds()} seconds")



    print("Completed the execution!!!!!!")

    return {
        'statusCode': 200,
        'body': 'Completed the execution!!!!!!'
    }

# lambda_handler('','')