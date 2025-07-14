import { prisma } from "../application/database.js";
import { HttpException } from "../middleware/error.js";

export const createNote = async (usersId, request) => {
    const note = await prisma.notes.create({
        data: {
            name: request.name,
            description: request.description,
            usersId: usersId,
        },
    });

    return note;
};

export const getNotes = async (usersId, page = 1, limit = 5) => {
    const skip = (page - 1) * limit;

    const totalNotes = await prisma.notes.count({
        where: {
            usersId: usersId,
        },
    });

    let notes = [];
    if (totalNotes > 0) {
        notes = await prisma.notes.findMany({
            where: {
                usersId: usersId,
            },
            skip: skip,
            take: limit,
        });
    }

    const totalPages = Math.ceil(totalNotes / limit);

    return {
        message: "notes retrived successfully",
        data: notes,
        paging: {
            page: page,
            page_size: limit,
            total_item: totalNotes,
            total_page: totalPages,
        },
    };
};

export const getNote = async (usersId, noteId) => {
    const note = await prisma.notes.findFirst({
        where: {
            id: noteId,
            usersId: usersId,
        },
    });

    if (!note) {
        throw new HttpException(404, "Note not found");
    }

    return note;
};

export const updateNote = async (userId, noteId, request) => {
    const note = await prisma.notes.update({
        where: {
            id: noteId,
            usersId: userId,
        },
        data: {
            name: request.name,
            description: request.description,
        },
    });

        if (!note) {
        throw new HttpException(404, "Note not found");
    }

    return note;
};

export const deleteNote = async (userId, noteId) => {
    const findNote = await prisma.notes.findFirst({
        where: {
        id: noteId,
        usersId: userId,
        },
    });

    if (!findNote) {
        throw new HttpException(404, "Note not found");
    }

    await prisma.notes.delete({
        where: {
        id: noteId,
        usersId: userId,
        },
    });

    return {
        message: "Note deleted successfully",
    };
};

