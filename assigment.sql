
-- Table for recording talked time
CREATE TABLE Talked_time (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    session_number INTEGER NOT NULL,
    device_id INTEGER,
    location VARCHAR(100),
    timestamp TIMESTAMP NOT NULL,
    talked_time INTEGER NOT NULL,
    talked_time_duration INTERVAL NOT NULL -- Added field for duration
);

-- Table for recording microphone usage
CREATE TABLE Microphone_used (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    session_number INTEGER NOT NULL,
    device_id INTEGER,
    location VARCHAR(100),
    timestamp TIMESTAMP NOT NULL,
    microphone_used BOOLEAN NOT NULL,
    microphone_model VARCHAR(50) -- Added field for microphone model
);

-- Table for recording speaker usage
CREATE TABLE Speaker_used (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    session_number INTEGER NOT NULL,
    device_id INTEGER,
    location VARCHAR(100),
    timestamp TIMESTAMP NOT NULL,
    speaker_used BOOLEAN NOT NULL,
    speaker_model VARCHAR(50) -- Added field for speaker model
);

-- Table for recording voice sentiment
CREATE TABLE Voice_sentiment (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL,
    session_number INTEGER NOT NULL,
    device_id INTEGER,
    location VARCHAR(100),
    timestamp TIMESTAMP NOT NULL,
    voice_sentiment DECIMAL(3, 2) NOT NULL
);

-- Indices for performance optimization
CREATE INDEX idx_talked_time_timestamp ON Talked_time(timestamp);
CREATE INDEX idx_microphone_used_timestamp ON Microphone_used(timestamp);
CREATE INDEX idx_speaker_used_timestamp ON Speaker_used(timestamp);
CREATE INDEX idx_voice_sentiment_timestamp ON Voice_sentiment(timestamp);

-- Example stored procedure to aggregate data
CREATE OR REPLACE FUNCTION aggregate_user_metrics(start_time TIMESTAMP, end_time TIMESTAMP)
RETURNS TABLE (
    user_id INTEGER,
    total_talked_time INTEGER,
    avg_voice_sentiment DECIMAL(3, 2)
) AS $$
BEGIN
    RETURN QUERY
    SELECT
        t.user_id,
        SUM(t.talked_time) AS total_talked_time,
        AVG(v.voice_sentiment) AS avg_voice_sentiment
    FROM
        Talked_time t
        JOIN Voice_sentiment v ON t.user_id = v.user_id
    WHERE
        t.timestamp BETWEEN start_time AND end_time
        AND v.timestamp BETWEEN start_time AND end_time
    GROUP BY
        t.user_id;
END;
$$ LANGUAGE plpgsql;
