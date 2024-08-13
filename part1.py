import psycopg2
import json
import random
import time
from datetime import datetime

def generate_metrics():
    metrics = [
        {'metric_type': 'talked_time', 'metric_value': random.uniform(0, 60)},
        {'metric_type': 'microphone_used', 'metric_value': random.choice([0, 1])},
        {'metric_type': 'speaker_used', 'metric_value': random.choice([0, 1])},
        {'metric_type': 'voice_sentiment', 'metric_value': random.uniform(-1, 1)}
    ]
    return metrics

def store_metrics(cursor, metrics, user_id, session_id):
    for metric in metrics:
        cursor.execute(
            "INSERT INTO user_metrics (user_id, session_id, metric_type, metric_value, timestamp) VALUES (%s, %s, %s, %s, %s)",
            (user_id, session_id, metric['metric_type'], metric['metric_value'], datetime.now())
        )

def main():
    conn = psycopg2.connect("dbname=metrics user=postgres password=yourpassword host=db")
    cursor = conn.cursor()

    while True:
        user_id = random.randint(1, 100)
        session_id = random.randint(1, 1000)
        metrics = generate_metrics()
        store_metrics(cursor, metrics, user_id, session_id)
        conn.commit()
        time.sleep(10)  # Simulate data streaming

if __name__ == "__main__":
    main()
