import express from "express";
import path from "path";
import os from "node:os";

const port = 8042;

const app = express();
app.use(express.static(path.join(__dirname, "static")));

app.get("/", (req, res) => {
		res.sendFile(path.join(__dirname, "public", "index.html"));
});

app.get("/api/uptime", (req, res) => {
    const uptimeSeconds = os.uptime() % 60;
    const uptimeMinutes = Math.round((os.uptime() / 60)) % 60;
    const uptimeHours = Math.round(((os.uptime() / 60) / 60)) % 24;
    const uptimeDays = Math.round((((os.uptime() / 60) / 60) / 24));

    res.send(JSON.stringify({
        sec: uptimeSeconds,
        min: uptimeMinutes,
        hrs: uptimeHours,
        day: uptimeDays
    }));
});

app.get("/api/layout", (req, res) => {
	res.sendFile(path.join(__dirname, "config", "layout.json"));
});

app.use((req, res, next) => {
	res.status(404).sendFile(path.join(__dirname, "public", "404", "index.html"))
});

const server = app.listen(port, () => {
	console.log(`App running on port ${port}`);
});
