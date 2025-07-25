import{register} from "../services/auth.js"
import { login } from "../services/auth.js";

export const authController = {
    register: async (req,res,next)=> {
        try{
            const result = await register(req.body);

            return res.status(201).json(result);
        } catch(error) {
            next(error) 
        }
    },

    login: async (req,res,next) => {
        try{
            const result = await login(req.body);

            return res.status(200).json(result);
        } catch (error) {
            next(error)
        }
    },





};