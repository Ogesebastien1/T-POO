type BaseUserType = {
    username: string;
    email: string;
};

type BaseWorkingTimeType = {
    end: string;
    start: string;
};

type BaseClockType = {
    status: boolean;
    time: string;
    user_id: string;   
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

export type CreatedWorkingTime = {
    userID: string;
    working_time: BaseWorkingTimeType;
  };
  
export type UpdatedWorkingTime = {
    id: string;
    working_time: BaseWorkingTimeType;
};

export type CreatedWorkingTimeType = {
    working_time: BaseWorkingTimeType;
};

export type CreatedClockType = {
    clock: BaseClockType;
};

export type CreatedClock = {
    userID: string;
    clock: CreatedClockType;
};