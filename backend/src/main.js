import { app } from "./application/server.js"

const PORT = 8000;

app.listen(PORT,() => {
    console.log("Server is running on port 8000");
});

