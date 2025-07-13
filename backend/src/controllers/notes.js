import { createNote, getNotes, getNote } from "../services/notes.js";

export const notesController = {
    create: async (req, res, next) => {
        try {
            const result = await createNote(req.user.id, req.body);
            return res.status(201).json(result);
        } catch (error) {
            next(error);
        }
    },
    get: async (req, res, next) => {
        try {
            const page = parseInt(req.query.page, 10) || 1;
            const limit = parseInt(req.query.page_size, 10) || 5;

            const result = await getNotes(req.user.id, page, limit);

            return res.status(200).json(result);
        } catch (error) {
            next(error);
        }
    },
    getOne: async (req, res, next) => {
    try {
        const result = await getNote(req.user.id, req.params.id);
        return res.status(200).json(result);
    } catch (error) {
        next(error);
    }
},

};