import { getProfile } from "../services/profile.js";

export const profileController = async (res,req,next) => {
    try{
        const result = await getProfile(req.user.id);
        return res.status(200).json(result);
    } catch(error){
        next(error);
    }
};