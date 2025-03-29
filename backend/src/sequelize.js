const pg = require("pg");
const { Sequelize, DataTypes } = require("sequelize");
const UserModel = require("./models/User");
const VideoModel = require("./models/Video");
const VideoLikeModel = require("./models/VideoLike");
const CommentModel = require("./models/Comment");
const SubscriptionModel = require("./models/Subscription");
const ViewModel = require("./models/View");

// Check if SSL is required (useful for local vs. production environments)
const isSSL = process.env.DATABASE_URL.includes("sslmode=require");

const sequelize = new Sequelize(process.env.DATABASE_URL, {
  logging: false,
  dialect: "postgres",
  dialectOptions: isSSL
    ? {
        ssl: {
          require: true,
          rejectUnauthorized: false,
        },
      }
    : {},
});

(async () => await sequelize.sync({ alter: true }))();

const User = UserModel(sequelize, DataTypes);
const Video = VideoModel(sequelize, DataTypes);
const VideoLike = VideoLikeModel(sequelize, DataTypes);
const Comment = CommentModel(sequelize, DataTypes);
const Subscription = SubscriptionModel(sequelize, DataTypes);
const View = ViewModel(sequelize, DataTypes);

// Associations
Video.belongsTo(User, { foreignKey: "userId" });
User.belongsToMany(Video, { through: VideoLike, foreignKey: "userId" });
Video.belongsToMany(User, { through: VideoLike, foreignKey: "videoId" });
User.hasMany(Comment, { foreignKey: "userId" });
Comment.belongsTo(User, { foreignKey: "userId" });
Video.hasMany(Comment, { foreignKey: "videoId" });
User.hasMany(Subscription, { foreignKey: "subscribeTo" });
User.belongsToMany(Video, { through: View, foreignKey: "userId" });
Video.belongsToMany(User, { through: View, foreignKey: "videoId" });

module.exports = {
  User,
  Video,
  VideoLike,
  Comment,
  Subscription,
  View,
};
