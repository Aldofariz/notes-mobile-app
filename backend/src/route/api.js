import {Router} from "express"
import { authController } from "../controllers/auth.js"
import { authHandler } from "../middleware/auth.js"
import { profileController } from "../controllers/profile.js";

export const router = Router();

router.post("/register", authController.register)
router.post("/login", authController.login)

router.use(authHandler)

router.get("/profile", profileController)