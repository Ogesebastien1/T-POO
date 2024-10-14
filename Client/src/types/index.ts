type BaseUserType = {
    username: string;
    email: string;
};

export type UpdatedUserType = {
    id: string;
    user: BaseUserType;
}

export type UserType = {
    id: number;
    is_manager: boolean;
    is_admin: boolean;
} & BaseUserType;

export type CreatedUserType = {
    user: BaseUserType;
};