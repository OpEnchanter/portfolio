import express from "express";
import path from "path";

const port = 8080;

const app = express();
app.use(express.static(path.join(__dirname, "static")));

app.get("/", (req, res) => {
		res.sendFile(path.join(__dirname, "public", "index.html"));
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
